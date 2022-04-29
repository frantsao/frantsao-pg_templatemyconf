# pg_templatemyconf
## Converting default PostgreSQL configurations in Ansible templates

### What?
This is a dirty [Perl](https://www.perl.org/) script that takes a [PostgreSQL](https://www.postgresql.org/) and  generates a postgresql.conf jinja2 template and a defaults vars YAML file. The idea is to use these files in [Ansible](https://github.com/ansible/ansible) roles and playbooks.

### How to run it?
In order to run pg\_templatemyconf, you must have installed Perl5 language and the Perl5 Getopt::Declare package.

Then you can execute the script:
```
$ ./pg_templatemyconf.pl -i postgresql.conf -t postgresql.conf.j2 -d defaults.yml
```

### Why?

I am lucky to use in several projects at [idealista](https://idealista.com) the best relational database in the world ;-) Also, [as you can see](https://github.com/idealista/) we use Ansible for configuration management. The product of this script is used at our [PostgreSQL role](https://github.com/idealista/postgresql_role).

### How?
Maybe you are interested in this documentation:
- [PostgreSQL Server Configuration documentation](https://www.postgresql.org/docs/current/runtime-config.html)
- [Ansible for DevOps](https://www.ansiblefordevops.com/)
- [The Camel book](https://en.wikipedia.org/wiki/Programming_Perl)
- [Getop::Declare documentation](https://metacpan.org/pod/Getopt::Declare)

### Status
Dirty but functional :-) Maybe in a future I can rewrite it to be more generic for other software configurations with different syntax.

### Built With

![Perl](https://img.shields.io/badge/Perl-5.34-green.svg)
![Getop::Declare](https://img.shields.io/badge/Getop::Declare-1.14-green.svg)

### About
![Simplified BSD License](https://img.shields.io/badge/SimplifiedBSDLicense-orange)

This work is under BSD 2-Clause License a.k.a Simplified BSD License (see see the [LICENSE](LICENSE) file). 
