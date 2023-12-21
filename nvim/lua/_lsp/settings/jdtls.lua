local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local jar = vim.fn.glob("/home/jshaver/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")

return {
  cmd = {
    '/opt/java-17/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx2g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:/home/jshaver/.local/share/nvim/mason/packages/jdtls/lombok.jar',
    '-jar', jar,
    '-jar', '/home/jshaver/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar',
    '-configuration', '/home/jshaver/.local/share/nvim/mason/packages/jdtls/config_linux',
    '-data', '/home/jshaver/jdtls_workspace/' .. project_name
  },
  root_dir = require('lspconfig/util').root_pattern(".git", "pom.xml"),
  settings = {
    java = {
      configuration = {
        runtimes = {
        {
            default = true,
            name = "JavaSE-1.8",
            path = "/opt/java/"
          }
        }
      }
    }
  }
}
