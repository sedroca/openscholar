<?php

/**
 * @file
 * Views handler for displaying link that creates news node based on feed item.
 */

class os_reader_handler_copy_feed_to_news extends views_handler_field {

  function render($values) {
    global $user;
    if (!$user->uid) {
      return;
    }

    $current_vsite = vsite_get_vsite();

    if (!empty($current_vsite)) {
      // Show button only for current VSite.
      $vsites = node_load_multiple(array($current_vsite->id));
    }
    else {
      // No current VSite, show button for all VSites.
      $groups = og_get_entity_groups();
      if (empty($groups['node'])) {
        return;
      }

      $vsites = node_load_multiple($groups['node']);
    }

    $items = array();
    foreach ($vsites as $vsite) {
      if (!og_user_access('node', $vsite->nid, 'create news content')) {
        // User does not have access to create "News" in VSite.
        continue;
      }

      if (os_reader_is_feed_item_copied_to_vsite($values->id, $vsite->nid)) {
        $items[] = !empty($current_vsite) ? t('Imported') : t('Imported to @vsite', array('@vsite' => $vsite->title));
      }
      else {
        $token = drupal_get_token($values->id . ':' . $vsite->nid);
        $options = array(
          'attributes' => array(
            'class' => array('use-ajax'),
          ),
        );
        $copy = !empty($current_vsite) ? t('Import') : t('Import to @vsite', array('@vsite' => $vsite->title));

        $url = l($copy, 'os-reader/copy-feed-to-news/' . $values->id . '/' . $vsite->nid . '/nojs/' . $token, $options);
        $items[] = "<span id='feed-{$values->id}-{$vsite->nid}'>$url</span>";
      }
    }

    return theme('item_list', array('items' => $items));
  }
}