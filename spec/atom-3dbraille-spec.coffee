Atom3dbraille = require '../lib/atom-3dbraille'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "Atom3dbraille", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('atom-3dbraille')

  describe "when the atom-3dbraille:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.atom-3dbraille')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'atom-3dbraille:convert'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.atom-3dbraille')).toExist()

        atom3dbrailleElement = workspaceElement.querySelector('.atom-3dbraille')
        expect(atom3dbrailleElement).toExist()

        atom3dbraillePanel = atom.workspace.panelForItem(atom3dbrailleElement)
        expect(atom3dbraillePanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'atom-3dbraille:toggle'
        expect(atom3dbraillePanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.atom-3dbraille')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'atom-3dbraille:convert'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        atom3dbrailleElement = workspaceElement.querySelector('.atom-3dbraille')
        expect(atom3dbrailleElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'atom-3dbraille:convert'
        expect(atom3dbrailleElement).not.toBeVisible()
