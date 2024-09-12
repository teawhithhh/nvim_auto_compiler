local M = {}

function M.setup(cxx_command_template, cxx_flags, cxx_build_bat, cxx_exists_path, py_command_template)
	CXX_CMD_TEMPLATE =  cxx_command_template
	CXX_FLAGS = cxx_flags
	CXX_BUILD_BAT = cxx_build_bat
	CXX_EXISTS_PATH = cxx_exists_path
	PY_CMD_TEMPLATE = py_command_template
end

function exist_file(path, filename)
	return vim.fn.system( CXX_EXISTS_PATH .. ' ' .. path .. '//' .. filename )
end

function CompileCxx(cxx_command_template, cxx_flags, build_bat, dir_to_build_file, source_file, output_dir, output_file)

	if exist_file(output_dir, build_bat) == '0' then
		print("Компиляция прошла успешно.\n")
    		vim.fn.system('wt"" cd "'.. output_dir ..'"' .. ' cmd /c "' .. output_dir .. "\\build.bat " .. ' && echo. && pause"')
		return;
	end

	local expanded_command = string.format(cxx_command_template, cxx_flags, source_file, output_dir, output_file)
	local start_cmd = string.format(dir_to_build_file, output_dir, output_file)
	local status = vim.fn.system(expanded_command)

  print(expanded_command)

  if status == '' then
    print("Компиляция прошла успешно.\n")
    vim.fn.system('wt new-tab PowerShell -c Start-Service; new-tab cmd cd "C:\\Users\\240821" /c "' .. start_cmd .. ' && echo. && pause && exit"')
	else
		print("Ошибка компиляции. Код ошибки:\n" .. status)
	end
end

function CompilePythone(py_command_template, source_file, output_dir, output_file)
	local expanded_command = string.format(py_command_template, source_file, output_dir, output_file)
	local start_cmd = expanded_command

	vim.fn.system('wt"" cd "C:\\Users\\240821" cmd /c "' .. start_cmd .. ' && echo. && pause"')
	print("Запуск прошел успешно.\n")
end

function CompileCommand()
	vim.cmd('w')
	local dir_to_build_file = '%s/%s.exe'
  	local source_file = vim.fn.expand('%:p')  -- полный путь к текущему файлу
  	local output_dir = vim.fn.expand('%:p:h')  -- каталог текущего файла с полным путем
  	local output_file = vim.fn.expand('%:t:r') -- имя текущего файла без расширения
  	local type_file = vim.fn.fnamemodify(source_file, ':e')
	
	print(type_file)
	
	if type_file == "cxx" or type_file == "cpp" then
		CompileCxx(CXX_CMD_TEMPLATE, CXX_FLAGS, CXX_BUILD_BAT, dir_to_build_file, source_file, output_dir, output_file)
	elseif type_file == "py" then
		CompilePythone(PY_CMD_TEMPLATE, source_file, output_dir, output_file)
	else
		print("Файл не поддерживает запуск")
 		return
	end
end

-- Создание команды для компиляции
vim.cmd('command! Compile lua CompileCommand()')

return M
