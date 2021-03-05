# Why?

## General

| Tool                               | Maintained    | Color | CLI | Library | Lang |
| ---------------------------------- | ------------- | ----- | --- | ------- | ---- |
| [Pass Station][0]                  | ✅ (2021-now)  | ✅     | ✅   | ✅       | 💎    |
| [Passhunt][1]                      | ❌ (2018-2018) | ❌     | ✅   | ❌       | 🐍    |
| [DefaultCreds-cheat-sheet `*1`][2] | ✅ (2020-now)  | ❌     | ✅   | ❌       | 🐍    |

- `*1`: `creds` script embedded in the project repository

Legend:

- ✅: feature supported
- ❌: feature not supported
- ⭕️: feature partially supported
- 💎: Ruby
- 🐍: Python

## Activity

| Tool                          | Last commit date                                                                                                    |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| [Pass Station][0]             | ![GitHub last commit](https://img.shields.io/github/last-commit/sec-it/pass-station?style=flat-square)              |
| [Passhunt][1]                 | ![GitHub last commit](https://img.shields.io/github/last-commit/Viralmaniar/Passhunt?style=flat-square)             |
| [DefaultCreds-cheat-sheet][2] | ![GitHub last commit](https://img.shields.io/github/last-commit/ihebski/DefaultCreds-cheat-sheet?style=flat-square) |

## Features

| Feature                            | [Pass Station][0] | [Passhunt][1] | [DefaultCreds-cheat-sheet][2] |
| ---------------------------------- | ----------------- | ------------- | ----------------------------- |
| List: list all default credentials | ✅                 | ✅             | ❌                             |
| Search                             | ✅                 | ✅             | ✅                             |
| Search: search in specific field   | ✅                 | ❌             | ❌                             |
| Search: case sensitivity switch    | ✅                 | ❌             | ❌                             |
| Search: highlight matched term     | ✅                 | ❌             | ❌                             |
| Output: simple table               | ✅                 | ❌             | ❌                             |
| Output: pretty table               | ✅                 | ❌             | ✅                             |
| Output: JSON                       | ✅                 | ❌             | ❌                             |
| Output: YAML                       | ✅                 | ❌             | ❌                             |
| Output: CSV                        | ✅                 | ❌             | ❌                             |
| Output: sort by column             | ✅                 | ❌             | ❌                             |

## Quality

| Tool                          | Package | Tests | Code Doc | User Doc | CI/CD | Lint rules |
| ----------------------------- | ------- | ----- | -------- | -------- | ----- | ---------- |
| [Pass Station][0]             | ✅       | ✅     | ✅        | ✅        | ❌     | ✅          |
| [Passhunt][1]                 | ❌       | ❌     | ❌        | ❌        | ❌     | ❌          |
| [DefaultCreds-cheat-sheet][2] | ❌       | ❌     | ❌        | ❌        | ❌     | ❌          |

[0]:https://github.com/sec-it/pass-station/
[1]:https://github.com/Viralmaniar/Passhunt
[2]:https://github.com/ihebski/DefaultCreds-cheat-sheet/blob/main/creds
