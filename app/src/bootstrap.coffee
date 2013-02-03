# @LESS 'bootstrap'
include sbks.ui.Button
include sbks.ui.TextBox

include sbks.ui.Dialog

include mold.ui.Designer
include goog.ui.Select
include goog.fx.Dragger
include goog.fx.DragDropGroup
include goog.fx.DragDrop

class app.Bootstrap 
	constructor: ->
	
		designer = new mold.ui.Designer
		
		designer.render()
		mout = goog.dom.createDom 'div', class: 'm-out'
		goog.dom.appendChild document.body, mout 
		
		components =	
			select: 
				create: ->
					new goog.ui.Select "Select"
				
			textbox: 
				create: ->
					new sbks.ui.TextBox "Text box"

			button: 
				create: ->
					sbks.ui.Button.GREY_SMALL 'Tlacitko'
		
		designer.components = components
		
		cdiv = goog.dom.getElementByClass 'm-components'
		
		list1 = new goog.fx.DragDropGroup
		
		for name, component of components
			li = goog.dom.createDom 'li', class: 'draggable'
			li.innerHTML = name
			component.li = li
			goog.dom.appendChild cdiv, li


		for name, component of components
			list1.addItem component.li, name
			
		button2 = new goog.fx.DragDrop  designer.getElement(), 'button 2'
		
		
		button2.setSourceClass('source')
		button2.setTargetClass('target')
		list1.setSourceClass('source')
		list1.setTargetClass('target')
		
		list1.addTarget button2 
		list1.addTarget(list1)
		list1.init()

		goog.events.listen list1, 'dragstart', (e) ->
			
			goog.style.setOpacity e.dragSourceItem.element, 0.5
		goog.events.listen list1, 'dragend', (e) ->
			goog.style.setOpacity e.dragSourceItem.element, 1


		goog.events.listen button2, 'dragover', (e) ->
			console.log e.dragSourceItem.element
			# goog.dom.classes.add e.dragSourceItem.element, 'drop' 
			goog.dom.classes.add  e.dropTargetElement, 'candrop' 
			# console.log e.dropTargetElement
		goog.events.listen button2, 'dragout', (e) ->
			goog.dom.classes.remove e.dropTargetElement, 'candrop' 

		goog.events.listen button2, 'drop', (e) ->
			console.log e.dragSourceItem.data
			console.log e
			goog.dom.classes.remove e.dropTargetElement, 'candrop' 
			
			designer.addComponent e.dragSourceItem.data, yes
			# alert 'x'
  
  			# new goog.fx.Dragger li
			
		
		# w = new modl.ui.Wrapper
		# 
		# b = sbks.ui.Button.CONFIRM()
		# w.wrap b
		# 
		# d.addChild w, yes
		# 
		# 
		# w = new modl.ui.Wrapper
		# b = new sbks.ui.TextBox
		# w.wrap b
		# 
		# d.addChild w, yes
		
	
		
	
		
		for item in ['textbox', 'button']
			designer.addComponent item
			
			
		
		
