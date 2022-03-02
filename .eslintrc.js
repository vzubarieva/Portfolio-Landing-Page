module.exports = {
	"env": {
		"browser": true,
		"es2021": true
	},
	"extends": "eslint:recommended",
	"parserOptions": {
		"ecmaVersion": "latest"
	},
	"rules": {
    "no-console": [
      "error"
    ],
    "no-var": [
      "error"
    ],
		"semi": [
			"error",
			"always"
		],
    "no-lonely-if": [
      "error"
    ],
    "no-unreachable": [
      "error"
    ],
    "no-debugger": [
      "error"
    ],
    "no-dupe-else-if": [
      "error"
    ],
    "no-irregular-whitespace": [
      "error"
    ]
	}
};
