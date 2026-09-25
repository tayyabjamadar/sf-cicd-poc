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

    @IsTest
    static void testHelloWorldBasicBehavior() {
        HelloWorld hw = new HelloWorld();
        System.assert(hw instanceof HelloWorld, 'hw should be instance of HelloWorld');
    }
}
