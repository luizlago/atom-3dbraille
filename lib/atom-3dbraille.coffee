Atom3dbrailleView = require './atom-3dbraille-view'
{CompositeDisposable} = require 'atom'
fs = require 'fs'

module.exports = Atom3dbraille =
  atom3dbrailleView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atom3dbrailleView = new Atom3dbrailleView(state.atom3dbrailleViewState)

    # Events subscribed to in atom'sHello, World!Hello, World! system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable
    @modalPanel = atom.workspace.addModalPanel(item: @atom3dbrailleView.getElement(), visible: false)
    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-3dbraille:convert': => @convert()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atom3dbrailleView.destroy()

  serialize: ->
    atom3dbrailleViewState: @atom3dbrailleView.serialize()

  convert: ->
    if @modalPanel.isVisible()
      @modalPanel.destroy()
    else
      @modalPanel = atom.workspace.addModalPanel(item: @atom3dbrailleView.getElement(), visible: false)
      @modalPanel.show()
