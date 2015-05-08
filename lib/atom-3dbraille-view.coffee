module.exports =
class Atom3dbrailleView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('atom-3dbraille')

    ifrm = document.createElement('iframe')
    ifrm.src = 'http://v01pe.github.io/Text2Braille3d/'
    ifrm.style.width = 600 + 'px'
    ifrm.style.height = 800 + 'px'
    #ifrm.style.border = 'none'
    @element.appendChild(ifrm)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
