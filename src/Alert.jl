###################################################
#
# Copyright © Akamai Technologies. All rights reserved.
# Proprietary and confidential.
#
# File: Alert.jl
#
# Functions to communicate with the mPulse Repository REST API regarding Alert Objects.
# This file MUST be `include()`d from `mPulseAPI.jl`
#
###################################################



export
    getRepositoryAlert,
    postRepositoryAlert

"""

Fetches an Alert object from the mPulse repository

The alert will be cached in memory for 1 hour, so subsequent calls using a matching `alertID` return
quickly without calling out to the API.  This can be a problem if the alert changes in the repository.
You can clear the cache for this tenant using [`mPulseAPI.clearAlertCache`](@ref) and passing in `alertID`.

#### Arguments
`token::AbstractString`
:    The Repository authentication token fetched by calling [`getRepositoryToken`](@ref)

#### Optional Arguments
`alertID::Int64`
:    The ID of the alert to fetch.

#### Returns
`{Dict}` The `alert` object with the following fields:

`hidden::Bool`
:    Flag indicating whether the alert is visible to the user

`parentID::Int64`
:    The ID of the parent folder that this alert is in

`path::AbstractString`
:    The folder path that this alert is in

`readOnly::Bool`
:    Flag indicating whether the alert is able to be edited

`name::AbstractString`
:    The alert's name

`tenantID::Int64`
:    The ID of the tenant in which the alert is in

`created::DateTime`
:    The timestamp when this object was created

`id::Int64`
:    The ID of the alert.

`description::AbstractString`
:    The description of this alert entered into mPulse

`lastCached::DateTime`
:    The timestamp when this object was last cached

`body::XMLElement`
:    An XML object representing the alert's XML definition or an empty node if you do not have permission to see the full alert

`references::Dict`
:    A `Dict` of locations in which this alert is referenced 

`uid::AbstractString`
:    The encrypted uid associated with the alert

`deleted::Bool`
:    Flag indicating whether the alert has been deleted

`ownerID::Int64`
:    The ID of the alert's owner

`attributes::Dict`
:    A `Dict` of attributes for this alert

`lastModified::DateTime`
:    The timestamp when this object was created

#### Throws
`ArgumentError`
:    if token is empty or alertID is empty

`mPulseAPIException`
:    if API access failed for some reason

"""
function getRepositoryAlert(token::AbstractString; alertID::Int64=0)

    alert = getRepositoryObject(
                token,
                "alert",
                Dict{Symbol, Any}(:id => alertID)
        )

    return alert

end




"""

TODO: documentation 

Updates an Alert object from the mPulse repository

The alert will be cached in memory for 1 hour, so subsequent calls using a matching `alertID` return
quickly without calling out to the API.  This can be a problem if the alert changes in the repository.
You can clear the cache for this tenant using [`mPulseAPI.clearAlertCache`](@ref) and passing in `alertID`.

#### Arguments
`token::AbstractString`
:    The Repository authentication token fetched by calling [`getRepositoryToken`](@ref)

#### Optional Arguments
`alertID::Int64`
:    The ID of the alert to update.

`attributes::Dict`
:    A `Dict` of alert attributes to update

`objectFields::Dict`
:    A `Dict` of alert object fields to update

#### Returns
`{Dict}` The updated `alert` object with the following fields:

`hidden::Bool`
:    Flag indicating whether the alert is visible to the user

`parentID::Int64`
:    The ID of the parent folder that this alert is in

`path::AbstractString`
:    The folder path that this alert is in

`readOnly::Bool`
:    Flag indicating whether the alert is able to be edited

`name::AbstractString`
:    The alert's name

`tenantID::Int64`
:    The ID of the tenant in which the alert is in

`created::DateTime`
:    The timestamp when this object was created

`id::Int64`
:    The ID of the alert.

`description::AbstractString`
:    The description of this alert entered into mPulse

`lastCached::DateTime`
:    The timestamp when this object was last cached

`body::XMLElement`
:    An XML object representing the alert's XML definition or an empty node if you do not have permission to see the full alert

`references::Dict`
:    A `Dict` of locations in which this alert is referenced 

`uid::AbstractString`
:    The encrypted uid associated with the alert

`deleted::Bool`
:    Flag indicating whether the alert has been deleted

`ownerID::Int64`
:    The ID of the alert's owner

`attributes::Dict`
:    A `Dict` of attributes for this alert

`lastModified::DateTime`
:    The timestamp when this object was created

#### Throws
`ArgumentError`
:    if token is empty or alertID is empty

`mPulseAPIException`
:    if API access failed for some reason


"""

function postRepositoryAlert(token::AbstractString;
                            alertID::Int64=0,
                            attributes::Dict=Dict(),
                            objectFields::Dict=Dict(),
                            body::Union{AbstractString, LightXML.XMLElement}=""
)

    postRepositoryObject(
        token,
        "alert",
        Dict{Symbol, Any}(:id => alertID),
        attributes = attributes,
        objectFields = objectFields,
        body = body
    )

    clearAlertCache(alertID = alertID)
    alert = getRepositoryAlert(token, alertID=alertID)

    return alert

end


