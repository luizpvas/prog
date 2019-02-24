export default function loadMarkdownEditor() {
	let nodes = document.querySelectorAll('[data-component="markdown-editor"]')
	for(let i = 0; i < nodes.length; i++) {
		init(nodes[i])
	}
}

function init(elm) {
	loadSimpleMDE(() => {
		let editor = new SimpleMDE({
			element: elm.querySelector('textarea'),
			spellChecker: false
		})
	})
}

let cssLoaded = false
let jsLoaded = false

function loadSimpleMDE(callback) {
	if(cssLoaded && jsLoaded) return callback()

	function checkLoaded() {
		if(cssLoaded && jsLoaded) return callback()
	}

	let css = document.createElement('link')
	css.rel = 'stylesheet'
	css.href = 'https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.css'
	css.onload = () => {
		cssLoaded = true;
		checkLoaded();
	}
	document.head.appendChild(css)

	let js = document.createElement('script')
	js.src = 'https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.js'
	js.onload = () => { 
		jsLoaded = true;
		checkLoaded();
	}
	document.head.appendChild(js)
}
