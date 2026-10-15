mkdir -p ~/.ssh
chmod 0700 ~/.ssh
cat > ~/.ssh/gcp_config <<'EOF'
Host gcp
  HostName 8.235.107.113
  User e
  IdentityFile ~/.ssh/google_compute_engine
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null
  LogLevel ERROR
EOF
