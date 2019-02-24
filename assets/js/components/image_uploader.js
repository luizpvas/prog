export default function loadImageUploader() {
	let nodes = document.querySelectorAll('[data-component="image-uploader"]')
	for(let i = 0; i < nodes.length; i++) {
		init(nodes[i])
	}
}

function init(elm) {
	let input = elm.querySelector('input')
	let output = elm.querySelector('[data-target="output"]')

	input.addEventListener('change', ev => {
		ev.preventDefault()

		let file = input.files[0]
		let form = new FormData()
		form.append("file", file)

		fetch('/images', {
			method: 'POST',
			headers: {
				'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content
			},
			body: form
		}).then(res => {
			return res.json();
		}).then(data => {
			output.innerHTML = data.url
		})
	})
}
