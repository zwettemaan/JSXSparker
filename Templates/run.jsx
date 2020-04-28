$include "targeting.jsx"
//@include "helpers/runtime.jsx"

main();

function main() {
    
    $$SHORTCODE$$.initScript();

    // Your code here...
$if "$$STARTERCODE$$" == "HelloWorld"
    alert("Hello World");
$endif

}
