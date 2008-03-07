/*
 PureMVC - Copyright(c) 2006-08 Futurecale, Inc., Some rights reserved.
 Your reuse is governed by Creative Commons Attribution 2.5 License
*/
package org.puremvc.as3.core
{
	import flexunit.framework.TestCase;
 	import flexunit.framework.TestSuite;
 	
 	import org.puremvc.as3.interfaces.*;
 	import org.puremvc.as3.patterns.observer.*;
 	
	/**
	 * Test the PureMVC Controller class.
	 *
  	 * @see org.puremvc.as3.core.controller.ControllerTestVO ControllerTestVO
  	 * @see org.puremvc.as3.core.controller.ControllerTestCommand ControllerTestCommand
	 */
 	public class ControllerTest extends TestCase {
  		
  		/**
  		 * Constructor.
  		 * 
  		 * @param methodName the name of the test method an instance to run
  		 */
  	    public function ControllerTest( methodName:String ) {
   			super( methodName );
           }
  	
 		/**
		 * Create the TestSuite.
		 */
 		public static function suite():TestSuite {
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new ControllerTest( "testGetInstance" ) );
   			ts.addTest( new ControllerTest( "testRegisterAndExecuteCommand" ) );
   			ts.addTest( new ControllerTest( "testRegisterAndRemoveCommand" ) );
   			ts.addTest( new ControllerTest( "testHasCommand" ) );
   			
   			return ts;
   		}
  		
  		/**
  		 * Tests the Controller Singleton Factory Method 
  		 */
  		public function testGetInstance():void {
  			
   			// Test Factory Method
   			var controller:IController = Controller.getInstance();
   			
   			// test assertions
   			assertTrue( "Expecting instance not null", controller != null );
   			assertTrue( "Expecting instance implements IController", controller is IController);
   		}

  		/**
  		 * Tests Command registration and execution.
  		 * 
  		 * <P>
  		 * This test gets the Singleton Controller instance 
  		 * and registers the ControllerTestCommand class 
  		 * to handle 'ControllerTest' Notifications.<P>
  		 * 
  		 * <P>
  		 * It then constructs such a Notification and tells the 
  		 * Controller to execute the associated Command.
  		 * Success is determined by evaluating a property
  		 * on an object passed to the Command, which will
  		 * be modified when the Command executes.</P>
  		 * 
  		 */
  		public function testRegisterAndExecuteCommand():void {
  			
   			// Create the controller, register the ControllerTestCommand to handle 'ControllerTest' notes
   			var controller:IController = Controller.getInstance();
   			controller.registerCommand('ControllerTest', org.puremvc.as3.core.ControllerTestCommand);
   			
   			// Create a 'ControllerTest' note
   			var vo:Object = new ControllerTestVO( 12 );
   			var note:Notification = new Notification( 'ControllerTest', vo );

			// Tell the controller to execute the Command associated with the note
			// the ControllerTestCommand invoked will multiply the vo.input value
			// by 2 and set the result on vo.result
   			controller.executeCommand(note);
   			
   			// test assertions 
   			assertTrue( "Expecting vo.result == 24", vo.result == 24 );
   		}
   		
  		/**
  		 * Tests Command registration and removal.
  		 * 
  		 * <P>
  		 * Tests that once a Command is registered and verified
  		 * working, it can be removed from the Controller.</P>
  		 */
  		public function testRegisterAndRemoveCommand():void {
  			
   			// Create the controller, register the ControllerTestCommand to handle 'ControllerTest' notes
   			var controller:IController = Controller.getInstance();
   			controller.registerCommand('ControllerRemoveTest', org.puremvc.as3.core.ControllerTestCommand);
   			
   			// Create a 'ControllerTest' note
   			var vo:Object = new ControllerTestVO( 12 );
   			var note:Notification = new Notification( 'ControllerRemoveTest', vo );

			// Tell the controller to execute the Command associated with the note
			// the ControllerTestCommand invoked will multiply the vo.input value
			// by 2 and set the result on vo.result
   			controller.executeCommand(note);
   			
   			// test assertions 
   			assertTrue( "Expecting vo.result == 24", vo.result == 24 );
   			
   			// Reset result
   			vo.result = 0;
   			
   			// Remove the Command from the Controller
   			controller.removeCommand('ControllerRemoveTest');
			
			// Tell the controller to execute the Command associated with the
			// note. This time, it should not be registered, and our vo result
			// will not change   			
   			controller.executeCommand(note);
   			
   			// test assertions 
   			assertTrue( "Expecting vo.result == 0", vo.result == 0 );
   			
   		}
  		
  		/**
  		 * Test hasCommand method.
  		 */
  		public function testHasCommand():void {
  			
   			// register the ControllerTestCommand to handle 'hasCommandTest' notes
   			var controller:IController = Controller.getInstance();
   			controller.registerCommand('hasCommandTest', org.puremvc.as3.core.ControllerTestCommand);
   			
   			// test that hasCommand returns true for hasCommandTest notifications 
   			assertTrue( "Expecting controller.hasCommand('hasCommandTest') == true", controller.hasCommand('hasCommandTest') == true );
   			
   			// Remove the Command from the Controller
   			controller.removeCommand('hasCommandTest');
			
   			// test that hasCommand returns false for hasCommandTest notifications 
   			assertTrue( "Expecting controller.hasCommand('hasCommandTest') == false", controller.hasCommand('hasCommandTest') == false );
   			
   		}
   		
  	}
}