{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "python-template.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "python-template.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "python-template.common.labels" -}}
app.kubernetes.io/name: {{ include "python-template.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "python-template.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Redis ha name
*/}}
{{- define "python-template.redis-ha.fullname" -}}
{{- if .Values.redisha.fullnameOverride -}}
{{- .Values.redisha.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.redisha.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create environment variables
*/}}
{{- define "python-template.env.config" -}}
REST_PORT: "80"

{{- range $key, $val := .Values.env }}
{{ printf "%s: %s" $key (quote $val) }}
{{- end }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "python-template.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "python-template.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create secret environment variables
*/}}
{{- define "python-template.env.secret" -}}
{{- range $key, $val := .Values.secrets }}
{{ printf "%s: %s" $key (b64enc $val | quote) }}
{{ end -}}
{{- end -}}

{{- define "python-template.full.labels" -}}
{{ include "python-template.common.labels" . }}
helm.sh/chart: {{ include "python-template.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}