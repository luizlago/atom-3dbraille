Atom3dbrailleView = require './atom-3dbraille-view'
{CompositeDisposable} = require 'atom'

module.exports = Atom3dbraille =
  atom3dbrailleView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atom3dbrailleView = new Atom3dbrailleView(state.atom3dbrailleViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atom3dbrailleView.getElement(), visible: false)

    # Events subscribed to in atom'sHello, World!Hello, World! system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

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
      @modalPanel.hide()
    else
      # show modal
      @modalPanel.show()
