local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
  s({trig="typescript-config"},
  {
    t({"{",
    "  \"extends\": [\"@tsconfig/strictest/tsconfig\", \"@tsconfig/node22/tsconfig\"],",
    "  \"compilerOptions\": {",
    "    \"module\": \"ES2022\",",
    "    \"moduleResolution\": \"node\",",
    "    \"baseUrl\": \"./src\",",
    "    \"allowImportingTsExtensions\": true,",
    "    \"noImplicitAny\": true,",
    "    \"isolatedModules\": true,",
    "    \"noEmit\": true,",
    "    \"outDir\": \"./dist\",",
    "    \"esModuleInterop\": true,",
    "    \"forceConsistentCasingInFileNames\": true,",
    "    \"strict\": true,",
    "    \"strictNullChecks\": true,",
    "    \"skipLibCheck\": true",
    "  }",
    "}"}),
  }
  ),
}
