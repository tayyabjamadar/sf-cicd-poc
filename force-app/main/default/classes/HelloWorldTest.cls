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
        Test.startTest();
        HelloWorld hw = new HelloWorld();
        Test.stopTest();
        System.assertNotEquals(null, hw);
    }
}
