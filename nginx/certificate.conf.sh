export CLUSTER_DOMAIN="soc.cp.fyre.ibm.com"
export INSTANCE_WORKSAPCE="dev"

# Create Certificate config based on domain and Maximo Instance workspace
cat > certificate.conf << EOF
[req]
default_bits       = 2048
default_keyfile    = localhost.key
distinguished_name = req_distinguished_name
req_extensions     = req_ext
x509_extensions    = v3_ca
prompt = no

[req_distinguished_name]
C  = NL
ST = Nord Holland
L  = Amsterdam
O  = IBM
OU = Support
CN = ${INSTANCE_WORKSAPCE}.apps.${CLUSTER_DOMAIN}

[req_ext]
subjectAltName = @alt_names

[v3_ca]
subjectAltName = @alt_names

[alt_names]
DNS.1   = admin.${INSTANCE_WORKSAPCE}.apps.${CLUSTER_DOMAIN}
DNS.2   = api.${INSTANCE_WORKSAPCE}.apps.${CLUSTER_DOMAIN}
DNS.3   = auth.${INSTANCE_WORKSAPCE}.apps.${CLUSTER_DOMAIN}
DNS.3   = home.${INSTANCE_WORKSAPCE}.apps.${CLUSTER_DOMAIN}
DNS.4   = workspace.home.${INSTANCE_WORKSAPCE}.apps.${CLUSTER_DOMAIN}
DNS.5   = workspace-all.${INSTANCE_WORKSAPCE}.apps.${CLUSTER_DOMAIN}
DNS.6   = maxinst.manage.${INSTANCE_WORKSAPCE}.apps.${CLUSTER_DOMAIN}
DNS.7   = workspace.manage.${INSTANCE_WORKSAPCE}.apps.${CLUSTER_DOMAIN}
EOF
