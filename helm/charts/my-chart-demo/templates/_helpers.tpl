{{/*
Expand the name of the chart.
*/}}
{{- define "my-chart-demo.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "my-chart-demo.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "my-chart-demo.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "my-chart-demo.labels" -}}
helm.sh/chart: {{ include "my-chart-demo.chart" . }}
{{ include "my-chart-demo.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "my-chart-demo.selectorLabels" -}}
app.kubernetes.io/name: {{ include "my-chart-demo.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "my-chart-demo.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "my-chart-demo.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Ce bloc peut être inclus dans une définition de Pod pour configurer les variables d'environnement pour les conteneurs.

Exemple de values.yaml  :

secret:
  name: secret-name

configmap:
  name: config-map-name

env:
  normal:
    PORT: "8080"

  secret:
    ENV_VAR_SECRET: "key-of-env-var-secret"

  configmap:
    ENV_VAR_CONFIG_MAP: "key-of-env-var-config-map"
    
*/}}
{{- define "helpers.list-env-variables"}}
    {{- range $key, $val := .Values.env.normal }}
    - name: {{ $key }}
      value: {{ $val | quote }}
    {{- end}}

    {{- range $key, $val := .Values.env.secret }}
    - name: {{ $key }}
      valueFrom:
        secretKeyRef:
            name: {{ $.Values.secret.name }}
            key: {{ $val }}
    {{- end}}

    {{- range $key, $val := .Values.env.configmap }}
    - name: {{ $key }}
      valueFrom:
        configMapKeyRef:
            name: {{ $.Values.configmap.name }}
            key: {{ $val }}
    {{- end}}    
{{- end }}


