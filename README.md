# vinay-digital

### MANDATORY

* `browsertype` browser name i.e., chrome , firefox. safari(in case mac) 


### Parallel test execution

```
currently we have only one feature file so parallel or not it will execute only on one node, in case if we have multiple feature files use below with parallel_cucumber gem in env.rb file
parallel_cucumber 'features/feature_files' -n 4 -o "-r features -t @VY_test browsertype=chrome"

```


### Tag definitions used for the test suites

**@VY_test**  - These are the scenarios with which we can execute all the tests from commandline 


### Commandline to execute in chrome browser 

```
cucumber -t @VY_test browsertype=chrome
 
```

### navigate to folder html_reports to fetch the results refer process.html
### Jenkins or bamboo setup on local can be achieved using the local CI/CD setup with and in script just add parallel_cucumber or cucumber cli commands to execute