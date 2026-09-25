@IsTest
private class HelloWorldTest {
    @IsTest
    static void testHelloWorldInstantiation() {
        HelloWorld hw = new HelloWorld();
        System.assert(hw != null);
    }

    @IsTest
    static void testHelloWorldConstructor() {
        HelloWorld hw = new HelloWorld();
        System.assertNotEquals(null, hw, 'HelloWorld instance should not be null');
    }
}
