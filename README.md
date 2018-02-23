LuaMock
------

The one lua testing framework that mocks classes, runs with real classes from
your project, has nginx embeded methods for openresty individual testing. Has a suite
of libraries preinstalled and you can specify libraries to install.

LuaMock runs better in docker than in standalone - all you need to do is pull
the image and run it like so


Table of contents
----
1. [Installing](#installing)
2. [Usage inside test classes](#ussage-inside-test-classes)
    1. [Mocking](#mock---mocking)
        - [Alter mock behaviour](#alter-mock-behaviour)
    2. [Running and skipping tests](#test-and-xtest---running-and-skipping)
        - [Running a test](#running-a-test)
        - [Running a test with exception](#running-a-test-that-throws-exception-or-you-know-it-will-fail)
        - [Skipping a test](#skipping-a-test)
    3. [Assertions](#assertions)
        - [assertEquals](#assertequals)
        - [assertNotEquals](#assertnotequals)
        - [assertNil](#assertnil)
        - [assertNotNil](#assertnotnil)
        - [Verify a mock has been called](#calls---verify-a-mock-has-been-called)
        
        



## Installing
- `sudo luarocks make mocka-1.0-1.rockspec`
- `sudo luarocks install luacov`

__Optional__:
- `sudo luarocks install luacov-coveralls`
- `lua -lluacov run_tests.lua`
- `luacov`
- `luacov-cobertura -o coverage_report.xml`

Sugest using:
 
__GitHub Pull Request Coverage Status__ and __Cobertura Plugin__


## Usage inside test classes

### mock(...) - Mocking

Mock whatever methods you want

``` 
    local classToMock = mock("path.to.class", {"method1", "method2"})
```

or mock all the methods dynamic

```
    local classToMock = mock("path.to.class")
```

#### Alter mock behaviour

``` 
    local classToMock = mock("path.to.class", {"method1", "method2"})
    when(classToMock).method1.fake(function(arg1, arg2)
        return arg1
    end)
```

or

```
    local classToMock = mock("path.to.class", {"method1", "method2"})
    when(classToMock).method1.doReturn = function(arg1, arg2)
            return arg1
    end
```

or

```
    local classToMock = mock("path.to.class", {"method1", "method2"})
    classToMock.__method1.doReturn = function(arg1, arg2)
        return arg1
    end
```

The only method that you don't want to alter if you mock is the __new__ function.

### test(...) and xtest(...) - Running and Skipping

#### Running a test
```
    test('describe what you are testing', function()
        assertEquals(true, true)
    end)
```


#### Running a test that throws exception or you know it will fail
```
    test('describe what you are testing', function()
        assertEquals(true, false)
    end, true)
```

#### Skipping a test
```
    xtest('describe what you are testing', function()
        assertEquals(true, true)
    end)
```

### Assertions

#### assertEquals 


```
    assertEquals(true, true)
```

```
    local one_object = {
        one = 1,
        two = 2
    }
    local second_object = {
        two = 2,
        one = 1
    }
    
    assertEquals(one_object, second_object)
```

```
    assertEqualse("string", "string")
```

```
    assertEquals(1,1)
```

```
    local first_array = {1, 2, 3}
    local second_array = {1, 2, 3}
    assertEquals(first_array, second_array)
```

#### assertNotEquals

```
    local first_array = {1, 2, 3}
    local second_array = {2, 1, 3}
    assertNotEquals(first_array, second_array)
```

#### assertNil

```
    assertNil(x)
```

#### assertNotNil

```
    local x = "string"
    assertNotNil(x)
```

#### calls(...) - verify a mock has been called

```
    local classToMock = mock("class", {"method"})
    calls(classToMock.__method, 1)
```

```
    local classToMock = mock("class", {"method"})
    calls(classToMock.__method, 1, arg2, arg1)
```