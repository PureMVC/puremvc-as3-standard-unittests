/*
 PureMVC - Copyright(c) 2006-08 Futurecale, Inc., Some rights reserved.
 Your reuse is governed by Creative Commons Attribution 2.5 License
*/
package org.puremvc.as3.core
{
   	/**
  	 * A utility class used by ControllerTest.
  	 * 
  	 * @see org.puremvc.as3.core.controller.ControllerTest ControllerTest
  	 * @see org.puremvc.as3.core.controller.ControllerTestCommand ControllerTestCommand
  	 */
	public class ControllerTestVO
	{
		/**
		 * Constructor.
		 * 
		 * @param input the number to be fed to the ControllerTestCommand
		 */
		public function ControllerTestVO (input:Number){
			this.input = input;
		}
		public var input:Number;
		public var result:Number;
	}
}