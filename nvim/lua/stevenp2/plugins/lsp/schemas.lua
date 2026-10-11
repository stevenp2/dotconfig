local json = {
  { description = "TypeScript compiler configuration", fileMatch = { "tsconfig.json", "tsconfig.*.json" }, url = "https://json.schemastore.org/tsconfig.json" },
  { description = "Lerna configuration", fileMatch = { "lerna.json" }, url = "https://json.schemastore.org/lerna.json" },
  { description = "Babel configuration", fileMatch = { ".babelrc.json", ".babelrc", "babel.config.json" }, url = "https://json.schemastore.org/babelrc.json" },
  { description = "ESLint configuration", fileMatch = { ".eslintrc.json", ".eslintrc" }, url = "https://json.schemastore.org/eslintrc.json" },
  { description = "ReScript configuration", fileMatch = { "bsconfig.json" }, url = "https://raw.githubusercontent.com/rescript-lang/rescript-compiler/8.2.0/docs/docson/build-schema.json" },
  { description = "Prettier configuration", fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" }, url = "https://json.schemastore.org/prettierrc" },
  { description = "Vercel configuration", fileMatch = { "now.json", "vercel.json" }, url = "https://json.schemastore.org/vercel.json" },
  { description = "Stylelint configuration", fileMatch = { ".stylelintrc", ".stylelintrc.json", "stylelint.config.json" }, url = "https://json.schemastore.org/stylelintrc" },
  { description = "npm package manifest", fileMatch = { "package.json" }, url = "https://json.schemastore.org/package.json" },

  { description = "ASP.NET launch settings", fileMatch = { "launchsettings.json" }, url = "https://json.schemastore.org/launchsettings.json" },
  { description = "CMake presets", fileMatch = { "CMakePresets.json", "CMakeUserPresets.json" }, url = "https://raw.githubusercontent.com/Kitware/CMake/master/Help/manual/presets/schema.json" },
  { description = "Code Climate configuration", fileMatch = { ".codeclimate.json" }, url = "https://json.schemastore.org/codeclimate.json" },
  { description = "LLVM compilation database", fileMatch = { "compile_commands.json" }, url = "https://json.schemastore.org/compile-commands.json" },
  { description = "Command Task Runner configuration", fileMatch = { "commands.json" }, url = "https://json.schemastore.org/commands.json" },
  { description = "golangci-lint configuration", fileMatch = { ".golangci.toml", ".golangci.json" }, url = "https://json.schemastore.org/golangci-lint.json" },
  { description = "Packer JSON template", fileMatch = { "packer.json" }, url = "https://json.schemastore.org/packer.json" },
  { description = "Visual Studio component configuration", fileMatch = { "*.vsconfig" }, url = "https://json.schemastore.org/vsconfig.json" },

  { description = "AWS CloudFormation template", fileMatch = { "*.cf.json", "cloudformation.json" }, url = "https://raw.githubusercontent.com/awslabs/goformation/v5.2.9/schema/cloudformation.schema.json" },
  { description = "AWS SAM template", fileMatch = { "serverless.template", "*.sam.json", "sam.json" }, url = "https://raw.githubusercontent.com/awslabs/goformation/v5.2.9/schema/sam.schema.json" },
  { description = "GitHub workflow-template properties", fileMatch = { ".github/workflow-templates/**.properties.json" }, url = "https://json.schemastore.org/github-workflow-template-properties.json" },
  {
    description = "JSON Feed",
    fileMatch = { "feed.json" },
    url = "https://json.schemastore.org/feed.json",
    versions = {
      ["1"] = "https://json.schemastore.org/feed-1.json",
      ["1.1"] = "https://json.schemastore.org/feed.json",
    },
  },
  { description = "JSON Resume", fileMatch = { "resume.json" }, url = "https://raw.githubusercontent.com/jsonresume/resume-schema/v1.0.0/schema.json" },
}

local yaml = {
  kubernetes = "*definition.{yml,yaml}",
  ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master-standalone/deployment.json"] = "deployment*.{yml,yaml}",
}

return { json = json, yaml = yaml }
