# This file is part of gitinbash.
#
# gitinbash is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# gitinbash is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with gitinbash. If not, see <http://www.gnu.org/licenses/>.
#
# Copyright (C) 2017 Artem Kozlov
# Contacts: <artemix-dev@yandex.ru>

COLOR_RED="\[\033[0;31m\]"
COLOR_YELLOW="\[\033[0;33m\]"
COLOR_GREEN="\[\033[0;32m\]"
COLOR_BROWN="\[\033[38;5;95m\]"
COLOR_BLUE="\[\033[0;34m\]"
COLOR_WHITE="\[\033[0;37m\]"
COLOR_RESET="\[\033[0m\]"

CHAR_CHECK="\xe2\x9c\x93"
CHAR_CROSS="\xc3\x97"
CHAR_DOT="\xe2\x88\x99"
CHAR_PLUS="+"
CHAR_ALT="\xe2\x8e\x87"

function __check_repo__ {
    local cur_branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
    if [[ -z "${cur_branch// }" ]]
    then
        exit 1
    fi
}

function __lscope__ {
    __check_repo__
    echo -ne " ["
}

function __rscope__ {
    __check_repo__
    echo -ne "]"
}

function __branch__ {
    __check_repo__
    echo -ne "$CHAR_ALT $(git rev-parse --abbrev-ref HEAD 2> /dev/null) | "
}

function __untracked__ {
    __check_repo__
    echo -ne $(git status -s 2> /dev/null | egrep "^\?\?" | wc -l)"$CHAR_CROSS "
}

function __modified__ {
    __check_repo__
    echo -ne $(git diff --name-only 2> /dev/null | wc -l)"$CHAR_DOT "
}

function __staged__ {
    __check_repo__
    echo -ne $(git diff --staged --name-only 2> /dev/null | wc -l)"$CHAR_PLUS"
}

PS1="$COLOR_RESET\W"
PS1+="\`__lscope__\`\`__branch__\`"
PS1+="$COLOR_RED\`__untracked__\`"
PS1+="$COLOR_YELLOW\`__modified__\`"
PS1+="$COLOR_GREEN\`__staged__\`"
PS1+="$COLOR_RESET\`__rscope__\` \$ "
export PS1
