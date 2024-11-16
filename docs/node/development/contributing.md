# Contribution guidelines

All contributions to VILLASframework are welcome! We are happy to receive your pull requests.

To keep our codebase maintainable and readable, we developed a few guidelines that we ask you to follow when contributing code.
The point of this document is to have clear rules that if followed should guarantee that a PR is accepted without much discussion.
Reviewers should only enforce these rules.

Discussions on the contributor guidelines should happend the in the [documentation repository](https://github.com/VILLASframework/documentation) and not in unrelated PRs.

As the codebase and these guidelines evolve, the codebase may not always be in full compliance with the guidelines.
Existing code should not be taken as and example for new code.
PRs that update the style of existing code should be made separate from PRs that change or add code.

## VILLASframework Coding Guidelines

1. Automated formatting tools
    1. **clang-format:** The VILLASframework uses clang-format to enforce a consistent code style. Please refer to the [clang-format configuration](https://github.com/VILLASframework/node/blob/master/.clang-format). Please run `clang-format` on your code before making a commit.
    2. **EditorConfig:** Please refer to the [editorconfig file](https://github.com/VILLASframework/node/blob/master/.editorconfig) on how to setup your editor.
2. Naming conventions
    1. Generally, we prefer verbose names over short names, especially if they are outside facing. Avoid naming things similarly.
    2. **File naming:** We use snake case for files. We use .cpp and .hpp as C++ file extensions.
    3. **Variables, functions, and types:** We use camel case for variables, functions, and types. Variables and functions begin with a lower case letter. Types begin with a capital case letter. Defines and Macros are all capital case, but `constexpr` variables should be prefered over defines.
    4. **config files:** We use snake case in JSON and config files. The JSON schemas should be kept up to date.
3. Comments
    1. A comment describing what a file contains should be part of every header file. If the file contains a class, this should include a describtion of its purpose. This description should not be duplicated in the source file.
    2. A SPDX license header must be present in every file. This mentions the authors, a copyright notice and a reference to the Apache-2.0 license. An example is:
    ```cpp
    /* This is a short description of what this file does.
    *
    * More detailed description expanding on the previous one.
    * This can also containt information about how to use the code,
    * some design decisions or other information that is not
    * obvious from the code.
    *
    * Author: FirstName LastName <email@domain.tld>
    * Author: FirstName2 LastName2 <email2@domain.tld>
    * SPDX-FileCopyrightText: 2024 FirstName LastName <email@domain.tld>
    * SPDX-FileCopyrightText: 2022-2023 Company of Author2
    * SPDX-License-Identifier: Apache-2.0
    */
    ```
    3. Commented code that is not part of an explanation is not allowed.
4. Commits
    - We use [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/).
    - You must agree to the [DCO](https://developercertificate.org/) and sign-off your commits. This is also enforced by the CI.
5. C++ Features
    1. **Error Handling:** Avoid using exceptions in new code.
    2. **RTTI:** Avoid RTTI in new code. If you need to check the type of an object, consider using a virtual function instead.
    3. **Templates:** Avoid using templates in new code.
6. Pull Requests
    1. We prefer small PRs over large ones that touch a lot of different files.
    2.  When a PR is submitted that follows all the rules, a review should not require changes to new/undocumented rules. Instead reviewers can add changes to a PR themselves. In this case they must also update this guidelines document.
7. Make the CI happy
    1. Only branches which pass the CI can be merged.

We referenced the [LLVM Coding Standards](https://llvm.org/docs/CodingStandards.html) when creating these guidelines. Although we do not follow them exactly, we believe in the benefits of following established standards.
Additions and changes to the guidelines should also be in line with guidelines of other major C++ projects.