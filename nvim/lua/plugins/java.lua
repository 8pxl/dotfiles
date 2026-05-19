return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jdtls = {
          -- Don't auto-configure jdtls with lspconfig, we'll use nvim-jdtls instead
          setup = false,
        },
      },
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    dependencies = {
      "mason-org/mason.nvim",
    },
    config = function()
      local jdtls = require("jdtls")
      local home = os.getenv("HOME")
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local workspace_dir = home .. "/.local/share/jdtls/workspace/" .. project_name

      -- Find jdtls installation via Mason
      local mason_registry = require("mason-registry")
      local jdtls_package = mason_registry.get_package("jdtls")
      local jdtls_path = jdtls_package:get_install_path()

      -- Path to your formatter configuration
      local formatter_config = vim.fn.getcwd() .. "/eclipse-java-formatter.xml"

      -- Check if formatter config exists, otherwise use default
      if vim.fn.filereadable(formatter_config) == 0 then
        formatter_config = nil
      end

      local config = {
        cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-Xmx1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
          "-jar",
          vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
          "-configuration",
          jdtls_path .. "/config_mac", -- Use config_linux on Linux, config_mac on macOS, config_win on Windows
          "-data",
          workspace_dir,
        },
        root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
        settings = {
          java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = "fernflower" },
            completion = {
              favoriteStaticMembers = {
                "org.junit.Assert.*",
                "org.junit.Assume.*",
                "org.junit.jupiter.api.Assertions.*",
                "org.junit.jupiter.api.Assumptions.*",
                "org.junit.jupiter.api.DynamicContainer.*",
                "org.junit.jupiter.api.DynamicTest.*",
                "org.mockito.Mockito.*",
                "org.mockito.ArgumentMatchers.*",
                "org.mockito.Answers.*",
              },
              filteredTypes = {
                "com.sun.*",
                "io.micrometer.shaded.*",
                "java.awt.*",
                "jdk.*",
                "sun.*",
              },
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
            codeGeneration = {
              toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
              },
              useBlocks = true,
            },
            -- Formatter settings
            format = {
              enabled = true,
              settings = {
                url = formatter_config,
                profile = "CS1331 Checkstyle",
              },
            },
          },
        },
        init_options = {
          bundles = {},
        },
        on_attach = function(client, bufnr)
          -- Enable completion triggered by <c-x><c-o>
          vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

          -- Mappings
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
          vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
          vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, bufopts)
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, bufopts)

          -- jdtls specific mappings
          vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, bufopts)
          vim.keymap.set("n", "<leader>jv", jdtls.extract_variable, bufopts)
          vim.keymap.set("n", "<leader>jc", jdtls.extract_constant, bufopts)
          vim.keymap.set("v", "<leader>jm", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], bufopts)
        end,
      }

      -- Start jdtls
      jdtls.start_or_attach(config)
    end,
  },
}
