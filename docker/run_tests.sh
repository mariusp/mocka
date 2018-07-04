#!/bin/sh

if [ -z "{$LUAROCKS_FILE}" ]; then
    sudo luarocks make ${LUAROCKS_FILE}
fi

if [ ! -z "{$DEP_INSTALL}" ]; then
    (IFS=,; for i in "${DEP_INSTALL}"
    do
        # call your procedure/other scripts here below
        eval "$(echo "sudo luarocks install ${i}")"
    done)
fi

if [ ! -z "{$LUA_LIBRARIES}" ]; then
    cp -r /mocka_space/${LUA_LIBRARIES}* /usr/local/share/lua/5.1/
fi

echo " Running luacheck for ${LUA_LIBRARIES} "
luacheck "${LUA_LIBRARIES}" --globals=ngx --no-self

if [ ! -z run_tests.lua ]; then

    lua -lluacov run_tests.lua \
        && luacov \
        && luacov-cobertura -o coverage_report.xml

    if [ ! -z "{$COVERALLS_REPO_TOKEN}" ]; then
        luacov-coveralls -t ${COVERALLS_REPO_TOKEN}
    fi
fi
