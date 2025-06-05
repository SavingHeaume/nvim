return {
	cmd = { "clangd" },
	fietypes = { "c", "cpp", "c" },
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
		"configure.ac", -- AutoTools
	},
	single_file_support = true,
}
