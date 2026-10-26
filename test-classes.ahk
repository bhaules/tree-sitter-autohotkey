; Test file for AHK v2 class definition syntax

; Simple class
class Animal {
    name := ""

    __New(name) {
        this.name := name
    }

    Speak() {
        MsgBox(this.name " says hello")
    }

    /**
    * @param string value
    * @param ?string extra
    * @return this
    */
    option(value, extra := "") {
        value := extra ? value . "" extra : value
        this._options["" . value . ""] := true
        return this
    }
}

; Class with inheritance
class Dog extends Animal {
    static count := 0
    breed

    __New(name, breed := "Unknown") {
        super.__New(name)
        Dog.count += 1
        this.breed := breed
    }

    __Delete() {
        Dog.count -= 1
    }

    Speak() {
        MsgBox(this.name " barks")
    }

    static GetCount() {
        return Dog.count
    }
}

; Nested class example
class Container {
    class Item {
        value := 0

        __New(val) {
            this.value := val
        }
    }

    items := []

    Add(val) {
        item := Container.Item(val)
        this.items.Push(item)
    }
}

; Meta-functions (__Get, __Set, __Call, __Enum)
class PropertyBag {
    data := {}

    __Get(key, params) {
        return this.data[key]
    }

    __Set(key, params, value) {
        this.data[key] := value
        return value
    }

    __Call(method, params) {
        MsgBox("Called " method)
    }
}

; Usage examples
dog := Dog("Rex", "German Shepherd")
dog.Speak()

container := Container()
container.Add(42)

; this and super in expressions
class Example {
    value := 10

    GetValue() {
        return this.value
    }

    GetChained() {
        return this.data.value
    }
}

class Extended extends Example {
    GetDouble() {
        return super.GetValue() * 2
    }
}

; Fat-arrow methods (property with getter)
class Circle {
    radius := 0

    __New(r) {
        this.radius := r
    }

    Area => 3.14159 * this.radius ** 2

    Circumference() {
        return 2 * 3.14159 * this.radius
    }
}

; Static class members and methods
class Config {
    static instance := unset
    static defaults := {
        theme: "dark",
        lang: "en"
    }

    static GetInstance() {
        if (!IsSet(Config.instance))
            Config.instance := Config()
        return Config.instance
    }
}

; By-reference parameters
class StringHelper {
    static TrimAndCheck(&str) {
        str := Trim(str)
        return str != ""
    }
}

; Variadic methods
class Logger {
    __New(prefix := "") {
        this.prefix := prefix
    }

    Log(msgs*) {
        for msg in msgs
            OutputDebug(this.prefix msg)
    }
}