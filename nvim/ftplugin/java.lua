local home = vim.fn.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local jar = vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
local root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1])

require("jdtls").start_or_attach({
  cmd = {
    "/opt/java-21/bin/java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Declipse.jdt.apt.aptEnabled=true",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx2g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
    "-jar",
    jar,
    "-configuration",
    home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
    "-data",
    home .. "/jdtls_workspace/" .. project_name .. "/",
  },
  on_attach = function(_, bufnr)
    require("_lsp.utils").lsp_keymaps(bufnr)
  end,
  root_dir = root_dir,
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            default = true,
            name = "JavaSE-1.8",
            path = "/opt/java/",
          },
        },
        maven = {
          userSettings = home .. "/.m2/settings.xml",
        },
      },
      import = {
        maven = {
          enabled = true,
        },
      },
      maven = {
        downloadSources = true,
        updateSnapshots = true,
      },
    },
  },
})
