return {
  settings = {
    yaml = {
      format = {
        enable = true,
      },
      hover = true,
      completion = true,
      -- cfn
      -- customTags = {
      --   "!fn",
      --   "!And",
      --   "!If",
      --   "!Not",
      --   "!Equals",
      --   "!Or",
      --   "!FindInMap sequence",
      --   "!Base64",
      --   "!Cidr",
      --   "!Ref",
      --   "!Ref Scalar",
      --   "!Sub",
      --   "!GetAtt",
      --   "!GetAZs",
      --   "!ImportValue",
      --   "!ImportValue Scalar",
      --   "!ImportValue sequence",
      --   "!Select",
      --   "!Split",
      --   "!Join sequence"
      -- },
      schemas = {
        kubernetes = "*definition.{yml,yaml}",
        -- FROM: https://github.com/yannh/kubernetes-json-schema
        ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master-standalone/deployment.json"] = "deployment*.{yml,yaml}"

        -- ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
        -- ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
        -- ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
        -- ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
        -- ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
        -- ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
        -- ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
        -- ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
        -- ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
        -- ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
        -- ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
        -- ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
      },
    },
  },
}
