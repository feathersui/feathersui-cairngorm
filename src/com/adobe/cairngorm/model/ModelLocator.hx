/*

	Copyright (c) 2007. Adobe Systems Incorporated.
	All rights reserved.

	Redistribution and use in source and binary forms, with or without
	modification, are permitted provided that the following conditions are met:

	  * Redistributions of source code must retain the above copyright notice,
		this list of conditions and the following disclaimer.
	  * Redistributions in binary form must reproduce the above copyright notice,
		this list of conditions and the following disclaimer in the documentation
		and/or other materials provided with the distribution.
	  * Neither the name of Adobe Systems Incorporated nor the names of its
		contributors may be used to endorse or promote products derived from this
		software without specific prior written permission.

	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
	IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
	ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
	LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
	CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
	SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
	INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
	CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
	POSSIBILITY OF SUCH DAMAGE.

	@ignore
 */

package com.adobe.cairngorm.model;

/**
	Deprecated, replaced by `com.adobe.cairngorm.model.IModelLocator`.

	Marker interface used to mark the custom ModelLocator.

	ModelLocator is the marker interface used by Cairngorm applications
	to implement the model in an Model-View-Controller architecture.

	The model locator in an application is a singleton that the application
	uses to store the client side model. An example implementation might be:

	```hx
	class ShopModelLocator implements ModelLocator {
		private static var instance:ShopModelLocator;

		public function new()  {   
			if (instance != null) {
				throw new CairngormError(
					CairngormMessageCodes.SINGLETON_EXCEPTION, "ShopModelLocator");
			}
		
			instance = this;
		}

		public static function getInstance():ShopModelLocator {
			if (instance == null) {
					instance = new ShopModelLocator();
			}

			return instance;
		}

		public var products:ICollectionView;
	}
	```

	Throughout the rest of the application, the developer can then access
	the products from the model, as follows:

	```hx
	var products:ICollectionView = ShopModelLocator.getInstance().products;
	```

**/
interface ModelLocator extends IModelLocator {}
