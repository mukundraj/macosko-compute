# Appendix

## Changing userid on your personal VM
- identify your uid on shared VM by running the following command on shared VM
    ```
    id -u
    ```
- log in to personal VM as different user (ask anyone in lab to log in to personal VM) and run the following command
    ```
    changeuid <your-username> <uid-on-shared-machine>

    ```
