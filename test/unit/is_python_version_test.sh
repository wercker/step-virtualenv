#!/bin/bash -e

source ./test/test_helper.sh
source ./support/wercker-functions.sh

describe "is_python_version"

it_returns_truthy_if_python_exists() {
    WERCKER_VIRTUALENV_PYTHON_PATH=`which python`
    result=$(set +e ; is_python_version ; echo $?)
    test 1 -eq $result
}

it_returns_falsy_if_python_doesnt_exist() {
    WERCKER_VIRTUALENV_PYTHON_PATH='/usr/doesnt/exist'
    result=$(set +e ; is_python_version ; echo $?)
    test 0 -eq $result
}

it_returns_falsy_if_it_is_not_python() {
    WERCKER_VIRTUALENV_PYTHON_PATH='ls'
    result=$(set +e ; is_python_version ; echo $?)
    test 0 -eq $result
}

it_returns_falsy_if_it_is_a_file() {
    WERCKER_VIRTUALENV_PYTHON_PATH='/etc/resolv.conf'
    result=$(set +e ; is_python_version ; echo $?)
    test 0 -eq $result
}