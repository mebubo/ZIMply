from setuptools import setup

setup(
        name='zimply',
        packages=['zimply'],
        version='1.1.4',
        description="ZIMply is an easy to use, offline reader for Wikipedia - as well as other ZIM files - which provides access "
                    "to them through any ordinary browser.",
        long_description="ZIMply is an easy to use, offline reader for Wikipedia - as well as other ZIM files - which provides access "
                    "to them through any ordinary browser. ZIMply is written entirely in Python 3 and, "
                         "as the name implies, relies on ZIM files. Each ZIM file is a bundle containing thousands "
                         "of articles, images, etc. as found on websites such as Wikipedia. ZIMply does all the "
                         "unpacking for you, and allows you to access the offline Wikipedia right from your "
                         "web browser by running its own web server.",
        author="Kim Bauters",
        author_email="kim.bauters@gmail.com",
        license='MIT',
        url="https://github.com/kimbauters/ZIMply",
        download_url='https://github.com/kimbauters/ZIMply/tarball/1.1.4',
        keywords=['zim', 'wiki', 'wikipedia'],
        install_requires=["gevent>=1.1.1", "falcon>=1.0.0", "mako>=1.0.3", "zstandard>=0.14.1"],
        classifiers=[
            'Programming Language :: Python :: 3.4',
            'License :: OSI Approved :: MIT License',
            'Development Status :: 5 - Production/Stable',
        ],
        include_package_data=True,
        platforms='any',
)
