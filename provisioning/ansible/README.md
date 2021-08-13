# provisioning

## playbooks

### GitHub Actions でポチる方法
基本的にはこれ。  
GitHub Actions の deploy_all workflow の `Run workflow` をポチって、ブランチを指定するだけ!

### 手動でやる方法
```sh
ansible-playbook prod.yaml --extra-vars "git_user=UserName git_pass=Passw0rd revision=feature/foo"
```
