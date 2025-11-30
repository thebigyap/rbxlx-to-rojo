const http = require("http");
const fs = require("fs");
const path = require("path");

const ROOT = path.join(__dirname, "exported");
const VERSION = "1.1.0";

function ensureDir(filePath) {
	fs.mkdirSync(path.dirname(filePath), { recursive: true });
}

const server = http.createServer((req, res) => {
	if (req.method === "POST" && req.url === "/save") {
		let body = "";
		req.on("data", chunk => {
			body += chunk;
		});
		req.on("end", () => {
			try {
				const data = JSON.parse(body);
				if (!data.path || !data.source) {
					throw new Error("Missing path or source");
				}

				const filePath = path.join(ROOT, data.path);
				ensureDir(filePath);
				fs.writeFileSync(filePath, data.source, "utf8");

				console.log("Saved", data.path);
				res.writeHead(200, { "ContentType": "text/plain" });
				res.end("OK");
			} catch (e) {
				console.error("Error saving script", e);
				res.writeHead(500, { "ContentType": "text/plain" });
				res.end("Error");
			}
		});
	} else {
		res.writeHead(404, { "ContentType": "text/plain" });
		res.end("Not found");
	}
});

const PORT = 8080;
server.listen(PORT, () => {
	console.log(`Server version ${VERSION} started.\nListening on http://localhost:${PORT}/save`);
});
