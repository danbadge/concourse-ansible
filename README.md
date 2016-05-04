Concourse CI 
============

Getting Started
---------------
You will need to ensure you have or install the following:
- [Install Ruby](https://www.ruby-lang.org/en/documentation/installation/) - Consider using a tool like [RVM](https://rvm.io/) to manage multiple Ruby versions. Most of us are working with version 2.1.5 of Ruby.
- [Install Python](https://docs.python.org/2/) - Again try [pyenv](https://github.com/yyuu/pyenv) for managing multiple versions of Python

Next, install Bundler and the Ruby-related dependencies (Serverspec, RSpec and Rake):
```
gem install bundler
bundle install
```

Assuming you have pip already as it generally ships with Python, you can install the Python dependencies (Ansible and Boto):
```
pip install -r requirements.txt
```

Local Dev Workflow
------------------
You will need Vagrant and Virtualbox installed.

You have the choice locally to use rake or tools like Vagrant directly, but here's the rough development flow:

Bring up the local VMs and provision:
```
rake provision
or
vagrant up
```

Run the tests:
```
rake spec
```

Make some changes to the code and the reconfigure the VMs:
```
rake configure
or
vagrant provision
```

Run tests again:
```
rake spec
```