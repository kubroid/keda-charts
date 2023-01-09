{{/* vim: set filetype=mustache: */}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "keda-addons-http.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Generate basic labels
*/}}
{{- define "keda-addons-http.labels" }}
helm.sh/chart: {{ include "keda-addons-http.chart" . }}
app.kubernetes.io/component: controller-manager
app.kubernetes.io/part-of: {{ .Chart.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Values.images.tag | default .Chart.AppVersion }}
{{- if .Values.additionalLabels }}
{{ toYaml .Values.additionalLabels }}
{{- end }}
{{- end }}

{{/*
    Selector labels
*/}}
{{- define "keda-addons-http.shared.selectorLabels" -}}
control-plane: interceptor
httpscaledobjects.http.keda.sh/version: {{ .Values.images.tag | default .Chart.AppVersion }}
keda.sh/addon: {{ .Chart.Name }}
{{- end }}
{{- define "keda-addons-http.interceptor.selectorLabels" -}}
{{ include "keda-addons-http.shared.selectorLabels" . }}
control-plane: interceptor
{{- end }}
{{- define "keda-addons-http.scaler.selectorLabels" -}}
{{ include "keda-addons-http.shared.selectorLabels" . }}
control-plane: external-scaler
{{- end }}
{{- define "keda-addons-http.operator.selectorLabels" -}}
{{ include "keda-addons-http.shared.selectorLabels" . }}
control-plane: controller-manager
{{- end }}