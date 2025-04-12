import argparse
from zimply import ZIMServer

def main():
    parser = argparse.ArgumentParser(description="ZIMply server.")
    parser.add_argument("--zim-path", required=True, help="Path to ZIM files or directory.")
    parser.add_argument("--index-dir", default=None, help="Path to the index directory.")
    parser.add_argument("--template", default="zimply/template.html", help="Path to the Mako template file.")
    parser.add_argument("--ip", default="0.0.0.0", help="IP address to bind to.")
    parser.add_argument("--port", type=int, default=8081, help="Port to listen on.")
    args = parser.parse_args()

    ZIMServer(
        args.zim_path,
        template=args.template,
        index_base=args.index_dir,
        ip_address=args.ip,
        port=args.port
    )

if __name__ == "__main__":
    main()
