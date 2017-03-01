===========
About this sample application
===========

This is a sample application that demonstrates how to build a serverless application using terraform and a terraform utility called downtoearth. Downtoearth autogenerates the terraform pieces required to build the api by allowing you to specify a simple representation of your api.

You can find more information about downtoearth at its `github page <https://github.com/cleardataeng/downtoearth>`_.

===========
Prerequisites
===========

* `Terraform <terraform.io>`_
* `Python virtualenv <http://docs.python-guide.org/en/latest/dev/virtualenvs/>`_

===========
Running the sample
===========

* Create and activate a python virtual env.
* Pull down the requirements `pip install -r requirements.txt`
* Clone the repo `git clone git@github.com:JohnBloom/dte-example.git`
* Build the api terraform `make build-tf`
* Run a plan `make plan-tf`
* If everything looks good apply the plan `make apply-tf`
