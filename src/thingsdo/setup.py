from setuptools import setup
setup(
    name='thingsdo',
    version='0.0.1',
    description='Todo and note management',
    packages=['thingsdo'],
    entry_points={
        'console_scripts': [
            'todo=thingsdo.cli.todo:run',
            'thing=thingsdo.cli.thing:run',
            'things=thingsdo.cli.things:run',
            'things-search=thingsdo.cli.search:run',
            'things-with-modified=thingsdo.cli.withModified:run',
        ]
    }
)
