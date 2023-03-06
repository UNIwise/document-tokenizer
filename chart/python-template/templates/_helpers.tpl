{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "document-tokenizer.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "document-tokenizer.fullname" -}}
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

{{- define "document-tokenizer.common.labels" -}}
app.kubernetes.io/name: {{ include "document-tokenizer.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "document-tokenizer.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Redis ha name
*/}}
{{- define "document-tokenizer.redis-ha.fullname" -}}
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
{{- define "document-tokenizer.env.config" -}}
REST_PORT: "80"

{{- range $key, $val := .Values.env }}
{{ printf "%s: %s" $key (quote $val) }}
{{- end }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "document-tokenizer.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "document-tokenizer.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create secret environment variables
*/}}
{{- define "document-tokenizer.env.secret" -}}
{{- range $key, $val := .Values.secrets }}
{{ printf "%s: %s" $key (b64enc $val | quote) }}
{{ end -}}
{{- end -}}

{{- define "document-tokenizer.full.labels" -}}
{{ include "document-tokenizer.common.labels" . }}
helm.sh/chart: {{ include "document-tokenizer.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}