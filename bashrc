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

COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_BROWN="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

UNICODE_CHECK="\xe2\x9c\x93"
UNICODE_CROSS="\xe2\x9c\x97"
UNICODE_BULLET="\xe2\x80\xa2"
UNICODE_PLUS="\xe2\x9c\x9b"

function __check_repo__ {
    local cur_branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
    if [[ ! -z "${cur_branch// }" ]]
    then
        # In bash 0 == true
        return 0
    else
        return 1
    fi
}

function __branch__ {
    if ( $(__check_repo__) )
    then
        echo -ne "[$(git rev-parse --abbrev-ref HEAD 2> /dev/null)] "
    fi
}

function __untracked__ {
    if ( $(__check_repo__) )
    then
        echo -ne $(git status -s 2> /dev/null | egrep "^\?\?" | wc -l)"$UNICODE_CROSS "
    fi
}

function __modified__ {
    if ( $(__check_repo__) )
    then
        echo -ne $(git diff --name-only 2> /dev/null | wc -l)"$UNICODE_BULLET "
    fi
}

function __staged__ {
    if ( $(__check_repo__) )
    then
        echo -ne $(git diff --staged --name-only 2> /dev/null | wc -l)"$UNICODE_CHECK "
    fi
}


PS1="\W \`__branch__\`"
PS1+="\[$COLOR_RED\]\`__untracked__\`"
PS1+="\[$COLOR_YELLOW\]\`__modified__\`"
PS1+="\[$COLOR_GREEN\]\`__staged__\`"
PS1+="\[$COLOR_RESET\]\$ "
export PS1
