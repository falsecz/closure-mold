# @LESS "designer"
include goog.ui.Component

class mold.ui.Designer extends goog.ui.Component
	constructor: ->
		super
		@wrappers = []
		
	createDom: ->
		super
		goog.dom.classes.add @getElement(), 'm-designer '
		@tree = []
	
	dumpTree: ->
		o = goog.dom.getElementByClass 'm-out'
		data = []
		for item in @wrappers
			data.push item.getModel()

		json = JSON.stringify data, no,  ' '
		o.innerHTML = ''
		p = goog.dom.createDom 'pre'
		goog.dom.appendChild o, p
		goog.dom.setTextContent p, json
		
	enterDocument: ->
		super
			
		@getHandler().listen @, goog.ui.Component.EventType.ACTION, (e) =>
			for wrapper in @wrappers
				wrapper.setSelected no unless wrapper is e.target
			console.log e.target	
		
	addComponent: (name, select)->
		
		# @tree.push name
		item = @components[name]
		w = new modl.ui.Wrapper
		w.setName name
		b = new item.create()
			
		w.wrap b
		@wrappers.push w 
		
		@addChild w, yes
		
		@dumpTree()
		 
		if select
			w.setSelected yes
			w.dispatchEvent goog.ui.Component.EventType.ACTION
		
		

class modl.ui.Wrapper extends goog.ui.Control
	setName: (@_name) ->
		
	createDom: ->
		super
		
		@setHandleMouseEvents yes
		@setSupportedState goog.ui.Component.State.SELECTED, yes
		 
		@contentEl = goog.dom.createDom 'div', class: 'm-wrapper-content'
		@overEl = goog.dom.createDom 'div', class: 'm-wrapper-over'
		
		goog.dom.appendChild @getElement(), @contentEl
		goog.dom.appendChild @getElement(), @overEl
		
		goog.dom.classes.add @getElement(), 'm-wrapper'
		
	getModel: ->
		return o =
				type: @_name
				
				
	wrap: (@component) ->
		#@component.render @contentEl
		@addChild @component, yes
		
	getContentElement: ->
		@contentEl
	setSelected: (selected) ->
		super
		console.log selected		
		
		