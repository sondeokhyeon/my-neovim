-- Spring Boot tmux pane 관리
local spring_panes = {
  run = nil, -- bootRun pane ID
  compile = nil, -- continuous compile pane ID
}

local function is_pane_alive(pane_id)
  if not pane_id then
    return false
  end
  local result = vim.fn.system("tmux has-session -t " .. pane_id .. " 2>/dev/null; echo $?")
  return vim.trim(result) == "0"
end

local function kill_pane(key)
  local pane_id = spring_panes[key]
  if is_pane_alive(pane_id) then
    vim.fn.system("tmux send-keys -t " .. pane_id .. " C-c")
    vim.defer_fn(function()
      vim.fn.system("tmux kill-pane -t " .. pane_id .. " 2>/dev/null")
      spring_panes[key] = nil
    end, 500)
  else
    spring_panes[key] = nil
  end
end

local function detect_build_tool()
  local root = vim.fn.getcwd()
  if vim.fn.filereadable(root .. "/gradlew") == 1 then
    return "gradle"
  elseif vim.fn.filereadable(root .. "/mvnw") == 1 then
    return "maven_wrapper"
  elseif vim.fn.filereadable(root .. "/pom.xml") == 1 then
    return "maven"
  end
  return "gradle"
end

return {
  -- Spring Boot Language Server (application.yml/properties 자동완성 및 검증)
  {
    "JavaHello/spring-boot.nvim",
    ft = { "java", "yaml" },
    dependencies = {
      "mfussenegger/nvim-jdtls",
    },
    config = function()
      require("spring_boot").setup({
        jdtls_name = "jdtls",
        server = {
          init_options = {
            enableJdtClasspath = true,
          },
        },
      })
    end,
  },
  -- Spring Boot 실행/생성 명령
  {
    "elmcgill/springboot-nvim",
    ft = "java",
    dependencies = {
      "mfussenegger/nvim-jdtls",
    },
    config = function()
      local springboot_nvim = require("springboot-nvim")

      -- Spring Boot Run + DevTools (tmux pane 직접 관리)
      vim.keymap.set("n", "<leader>Jr", function()
        -- 기존 패널이 있으면 먼저 종료
        kill_pane("run")
        kill_pane("compile")

        local tool = detect_build_tool()
        local run_cmd, compile_cmd

        if tool == "gradle" then
          run_cmd = "./gradlew bootRun"
          compile_cmd = "./gradlew -t classes"
        elseif tool == "maven_wrapper" then
          run_cmd = "./mvnw spring-boot:run"
          compile_cmd = "./mvnw compile -q"
        else
          run_cmd = "mvn spring-boot:run"
          compile_cmd = "mvn compile -q"
        end

        vim.defer_fn(function()
          -- bootRun 패널 생성 (아래 30%)
          local run_pane = vim.fn.system("tmux split-window -v -p 30 -P -F '#{pane_id}' -d")
          spring_panes.run = vim.trim(run_pane)
          vim.fn.system("tmux send-keys -t " .. spring_panes.run .. " '" .. run_cmd .. "' Enter")

          -- continuous compile 패널 생성 (bootRun 오른쪽)
          local compile_pane = vim.fn.system(
            "tmux split-window -h -t " .. spring_panes.run .. " -p 30 -P -F '#{pane_id}' -d"
          )
          spring_panes.compile = vim.trim(compile_pane)
          vim.fn.system("tmux send-keys -t " .. spring_panes.compile .. " '" .. compile_cmd .. "' Enter")

          vim.notify("Spring Boot started (run: " .. spring_panes.run .. ", compile: " .. spring_panes.compile .. ")")
        end, 600)
      end, { desc = "Spring Boot Run + DevTools (tmux)" })

      -- bootRun만 단독 실행
      vim.keymap.set("n", "<leader>JR", function()
        kill_pane("run")

        local tool = detect_build_tool()
        local cmd
        if tool == "gradle" then
          cmd = "./gradlew bootRun"
        elseif tool == "maven_wrapper" then
          cmd = "./mvnw spring-boot:run"
        else
          cmd = "mvn spring-boot:run"
        end

        vim.defer_fn(function()
          local run_pane = vim.fn.system("tmux split-window -v -p 30 -P -F '#{pane_id}' -d")
          spring_panes.run = vim.trim(run_pane)
          vim.fn.system("tmux send-keys -t " .. spring_panes.run .. " '" .. cmd .. "' Enter")
          vim.notify("Spring Boot started (run: " .. spring_panes.run .. ")")
        end, 600)
      end, { desc = "Spring Boot Run (tmux)" })

      -- Spring Boot 프로세스 중단 (Ctrl-C → 정확히 Spring Boot 패널에만 전송)
      vim.keymap.set("n", "<leader>Jk", function()
        if is_pane_alive(spring_panes.run) then
          vim.fn.system("tmux send-keys -t " .. spring_panes.run .. " C-c")
          vim.notify("Spring Boot stopping...")
        else
          vim.notify("No running Spring Boot process", vim.log.levels.WARN)
        end
      end, { desc = "Spring Boot Stop" })

      -- 모든 Spring Boot 패널 종료
      vim.keymap.set("n", "<leader>Jq", function()
        kill_pane("compile")
        kill_pane("run")
        vim.notify("Spring Boot panes closed")
      end, { desc = "Spring Boot Close All" })

      -- Spring Boot 패널로 포커스
      vim.keymap.set("n", "<leader>Jf", function()
        if is_pane_alive(spring_panes.run) then
          vim.fn.system("tmux select-pane -t " .. spring_panes.run)
        else
          vim.notify("No Spring Boot pane", vim.log.levels.WARN)
        end
      end, { desc = "Focus Spring Boot pane" })

      vim.keymap.set("n", "<leader>Jc", springboot_nvim.generate_class, { desc = "Java Create Class" })
      vim.keymap.set("n", "<leader>Ji", springboot_nvim.generate_interface, { desc = "Java Create Interface" })
      vim.keymap.set("n", "<leader>Je", springboot_nvim.generate_enum, { desc = "Java Create Enum" })
    end,
  },
}
