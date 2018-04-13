const activate = (Oni) => {
   console.log("config activated")
}

const deactivate = () => {
   console.log("config deactivated")
}

module.exports = {
   activate,
   deactivate,
  "oni.useDefaultConfig": true,
  //"oni.bookmarks": ["~/Documents",]
  "oni.loadInitVim": true,
  //"editor.fontSize": "14px",
  //"editor.fontFamily": "Monaco"
  "editor.textMateHighlighting.enabled": true
}
