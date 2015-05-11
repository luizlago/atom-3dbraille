module.exports =
class Atom3dbrailleView
  constructor: (serializedState) ->
    # Create root element
    editor = atom.workspace.activePaneItem
    txt = editor.buffer.getText()
    @element = document.createElement('div')
    @element.classList.add('atom-3dbraille')
    @element.style.background = '#fff'
    ifrm = document.createElement('iframe')
    ifrm.src = 'http://luizlago.github.io/atom-3dbraille/?text=' + txt
    ifrm.style.width = 100 + '%'
    ifrm.style.height = 665 + 'px'
    ifrm.style.border = 'none'
    ifrm.scrolling = 'no'
    @element.appendChild(ifrm)
    #@element.innerHTML = JSON.stringify(txt);

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
