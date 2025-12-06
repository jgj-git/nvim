return
{
    "m-gail/diagnostic_manipulation.nvim",
    init = function ()
        require("diagnostic_manipulation").setup {
            blacklist = {
                -- ignore uvm_macros.svh message
                function (diagnostic)
                    return string.match("'uvm_macros.svh': No such file or directory", diagnostic.message)
                end,
                -- ignore uvm_pkg import
                function (diagnostic)
                    return string.match(diagnostic.message, "unknown package 'uvm_pkg'")
                end,
                -- ignore uvm undeclared identifiers
                function (diagnostic)
                    return string.match(diagnostic.message, "use of undeclared identifier 'uvm_.*'")
                end
            },
            whitelist = {
            }
        }
    end
}
