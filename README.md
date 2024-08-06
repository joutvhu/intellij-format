# IntelliJ Reformat Code

GitHub Action for code formatting using IntelliJ IDEA

## Usage

See [action.yml](action.yml)

## Inputs

- `path`: Path to project directory. The formatter is executed recursively from here. Must be relative to the
  workspace. (__Default__: `.`)

- `mask`: Specify a comma-separated list of file masks that define the files to be processed. You can use the * (any
  string) and ? (any single character) wildcards.

- `settings`: Specify the code style settings file to use for formatting. This can be one of the following:

    - A file with the exported code style settings: open the Editor | Code Style page of the IDE settings Ctrl+Alt+S,
      click The Show Scheme Actions button, and select Export.

    - The .idea/codeStyleSettings.xml file stored in your project directory (for IntelliJ IDEA version 2017.2 and
      earlier).

    - The .idea/codeStyles/Project.xml file stored in your project directory (for IntelliJ IDEA version 2017.3 and
      later).

  The formatter also looks for .editorconfig files in the parent directories, and you can explicitly use EditorConfig
  for formatting instead of the IntelliJ IDEA code style settings. For more information, see Manage code style on a
  directory level with EditorConfig.

- `message`: The commit message to use when committing. If the message is empty, changes will not be committed. (__
  Default__: `Reformat code with IntelliJ`)

- `verify`: If true, the action will fail if any file changed. (__Default__: `false`)

## Outputs

- `changed`: Outputs the number of files which were formatted.

## Example

```yaml
name: IntelliJ Reformat Code

on:
  push:
    branches: [ develop ]

jobs:
  reformat:
    runs-on: ubuntu-latest
    permissions:
      contents: write
    steps:
      - uses: actions/checkout@v4

      - uses: joutvhu/intellij-format@v1
```
